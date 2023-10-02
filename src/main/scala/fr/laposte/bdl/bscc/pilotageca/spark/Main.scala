package fr.laposte.bdl.bscc.pilotageca.spark

import fr.laposte.bdl.bscc.utlv4scala.UtlLogging
import org.apache.spark.sql.SparkSession
import org.slf4j.{Logger, LoggerFactory}
import scala.util.Properties


/** Classe principale.
  *
  */
object Main extends App {

  val logger : Logger = LoggerFactory.getLogger(getClass.getCanonicalName)

  UtlLogging.info(logger, Array(s"DEBUT DU TRAITEMENT - Scala=${Properties.versionNumberString}"))
  UtlLogging.info(logger, Array(s"DEMARRAGE DU CONTEXTE SPARK"))

  val spark = SparkSession.builder().enableHiveSupport().getOrCreate()

  UtlLogging.info(logger, Array(s"CONTEXTE SPARK DEMARRE - Spark=${spark.version}"))

  WorkDriver.doit(spark)

  UtlLogging.info(logger, Array(s"ARRET DU CONTEXTE SPARK - Spark=${spark.version}"))

  spark.stop()

  UtlLogging.info(logger, Array(s"CONTEXTE SPARK ARRETE - Spark=${spark.version}"))
  UtlLogging.info(logger, Array(s"FIN DU TRAITEMENT - Scala=${Properties.versionNumberString}"))

  // surtout pas d'appel a "System.exit()" car cela shunterait le processus d'arret de Spark

}
