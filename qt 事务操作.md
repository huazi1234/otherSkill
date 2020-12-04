 if(mydb.isOpen())
            {
                //vec.swap(vecSql);
                swapData(vec);

                if(QSqlDatabase::database("ThreadUpdateDataToDB").driver()->hasFeature(QSqlDriver::Transactions))
                {
                    //qDebug()<<"事务操作模式";
                    if(QSqlDatabase::database("ThreadUpdateDataToDB").transaction())
                    {
                        for(int i =0;i<vec.size();i++)
                        {
                            if(!bStateRun)
                                break;
                            if(vec.at(i).isEmpty())
                                continue;
                            if(!query.exec(vec.at(i)))
                            {
                                qDebug()<<"SqlQuery is failed!";
                                qDebug()<<vec.at(i);
                            }
                        }
                        if(!QSqlDatabase::database("ThreadUpdateDataToDB").commit())
                        {

                            qDebug()<< QSqlDatabase::database("ThreadUpdateDataToDB").lastError();
                            if(!QSqlDatabase::database("ThreadUpdateDataToDB").rollback())
                                qDebug()<< QSqlDatabase::database("ThreadUpdateDataToDB").lastError();
                        }
                    }
                }
