package fr.laposte.bdl.bscc.pilotageca.standalone

import fr.laposte.bdl.bscc.pilotageca.common.AppConfig
import fr.laposte.bdl.bscc.utlv4scala.UtlLogging
import org.slf4j.{Logger, LoggerFactory}


/** Classe qui centralise les traitements.
  *
  */
object Work {

  // le logger de la classe
  val logger : Logger = LoggerFactory.getLogger(getClass.getCanonicalName)

  // chargement de la conf
  AppConfig.load()

  // affichage de la conf
  AppConfig.logInfo(logger)


  /** Traitements a effectuer.
    *
    */
  def doit() : Unit = {

    // affichage cle de parametrage "cle"
    UtlLogging.debug(logger, Array("debug/app.cle=" + AppConfig.getCle))
    UtlLogging.info(logger, Array("info/app.cle=" + AppConfig.getCle))

  }
}
