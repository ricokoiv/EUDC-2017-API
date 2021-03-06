package eudcApi;

import com.google.inject.Singleton;
import eudcApi.guice.GuiceInjector;
import eudcApi.server.EmbeddedJetty;
import eudcApi.service.AuthenticatedUserService;
import eudcApi.utils.ConfigurationProperties;
import org.apache.commons.configuration.Configuration;
import org.apache.log4j.Logger;


import javax.inject.Inject;

import java.util.Arrays;
import java.util.concurrent.Executors;

import static java.lang.String.format;

@Singleton
public class ApplicationLauncher {

    private static final Logger logger = Logger.getLogger(ApplicationLauncher.class);

    private static final int DEFAULT_SERVER_PORT = 7070;

    @Inject
    private static Configuration configuration;

    public static void startApplication() {
        GuiceInjector.init();

        if (ApplicationManager.isApplicationRunning()) {
            logger.warn("Unable to start. Application is already running.");
        } else {
            startServer();
            addShutdownHook();
            startCommandListener();
            Executors.newSingleThreadExecutor().submit(() -> {
                GuiceInjector.getInjector().getInstance(AuthenticatedUserService.class);
            });
        }
    }

    private static void startCommandListener() {
        Thread commandListener = new Thread(new ApplicationManager.CommandListener());
        commandListener.setName("command-listener");
        commandListener.setDaemon(true);
        commandListener.start();
    }

    private static void addShutdownHook() {
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            stopServer();
        }, "shutdown-hook"));
    }

    private static void startServer() {
        try {
            int port = configuration.getInt(ConfigurationProperties.SERVER_PORT, DEFAULT_SERVER_PORT);
            logger.info(format("Starting application server on port [%s]", port));
            EmbeddedJetty.instance().start(port);
        } catch (Exception e) {
            logger.error("Error inicializing Jetty Server. Existing application.", e);
            System.exit(1);
        }
    }

    synchronized private static void stopServer() {
        logger.info("Stopping server...");
        try {
            EmbeddedJetty.instance().stop();
        } catch (Exception e) {
            logger.info("Error stopping server!", e);
        }
    }

    public static void stopApplication() throws Exception {
        GuiceInjector.init();
        ApplicationManager.stopApplication();
    }

    public static void main(String[] args) throws Exception {
        if (args.length == 0 || "start".equalsIgnoreCase(args[0])) {
            startApplication();
        } else if ("stop".equalsIgnoreCase(args[0])) {
            stopApplication();
        } else {
            logger.warn("Command does not exist. Use: start, stop or no command (default is start)." + Arrays.toString(args));
        }
    }
}
