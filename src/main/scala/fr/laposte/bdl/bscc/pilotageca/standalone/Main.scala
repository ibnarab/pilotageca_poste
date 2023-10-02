package fr.laposte.bdl.bscc.pilotageca.standalone

import fr.laposte.bdl.bscc.utlv4scala.UtlLogging
import org.slf4j.{Logger, LoggerFactory}
import scala.util.Properties


/** Classe principale.
  *
  */
object Main extends App {

  val logger : Logger = LoggerFactory.getLogger(getClass.getCanonicalName)

  UtlLogging.info(logger, Array(s"DEBUT DU TRAITEMENT - Scala=${Properties.versionNumberString}"))

  val res = Work.doit()

  UtlLogging.info(logger, Array(s"FIN DU TRAITEMENT - Scala=${Properties.versionNumberString}"))

  System.exit(0)
}
