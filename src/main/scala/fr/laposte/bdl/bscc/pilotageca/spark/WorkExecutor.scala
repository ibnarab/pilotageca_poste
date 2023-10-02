package fr.laposte.bdl.bscc.pilotageca.spark

import fr.laposte.bdl.bscc.pilotageca.common.AppConfig
import fr.laposte.bdl.bscc.utlv4scala.UtlLogging
import org.apache.spark.TaskContext
import org.slf4j.{Logger, LoggerFactory}


/** Classe qui centralise les traitements des EXECUTORS.
  *
  */
object WorkExecutor {

  // le logger de la classe
  val logger : Logger = LoggerFactory.getLogger(getClass.getCanonicalName)

  // chargement de la conf
  AppConfig.load()

  // affichage de la conf
  AppConfig.logInfo(logger)


  /** Traite une partition.
    *
    * @param partition Iterateur sur la partition a traiter.
    *
    */
  def doitPartition(partition : Iterator[(Int, String)]) : Unit = {

    val partid = TaskContext.getPartitionId

    UtlLogging.info(logger, Array(s"DEBUT PARTITION=$partid - app.cle=${AppConfig.getCle}"))

    // parcours des lignes de la partitions
    partition.foreach(doitRow)

    UtlLogging.info(logger, Array(s"FIN PARTITION=$partid"))
  }


  /** Traite une ligne de la partition.
    *
    * @param row  Ligne a traiter.
    *
    */
  def doitRow(row : (Int, String)) : Unit = {
    UtlLogging.info(logger, Array(s"PARTITION=${TaskContext.getPartitionId} - ROW=$row - app.cle=${AppConfig.getCle}"))

    // on attend expres 10 secondes pour verifier que tous les cores seront en execution
//    Thread.sleep(10000)
  }

}
