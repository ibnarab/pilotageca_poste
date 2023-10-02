package fr.laposte.bdl.bscc.pilotageca.common

import fr.laposte.bdl.bscc.utlv4scala.UtlConfig
import org.slf4j.Logger


/** Classe de gestion de la configuration applicative.
  *
  */
object AppConfig {

  // charger la conf
  def load() : Unit = {
    UtlConfig.load()
  }

  // tout logguer en niveau "info"
  def logInfo(logger: Logger) : Unit =  {
    UtlConfig.logInfo(logger, "app")
  }

  // recupérer la cle "cle"
  def getCle : String = UtlConfig.get("app.cle", "<undefined>")
}
