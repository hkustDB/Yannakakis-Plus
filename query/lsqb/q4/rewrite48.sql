create or replace view aggView4296033946367027158 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin4020901238620431441 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4296033946367027158 where Person_likes_Message.MessageId=aggView4296033946367027158.v1;
create or replace view aggView5707375393086315013 as select v1, SUM(annot) as annot from aggJoin4020901238620431441 group by v1;
create or replace view aggJoin8426194376442301309 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5707375393086315013 where Message_hasCreator_Person.MessageId=aggView5707375393086315013.v1;
create or replace view aggView4782109357683745589 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin6482615917375369171 as select aggJoin8426194376442301309.annot * aggView4782109357683745589.annot as annot from aggJoin8426194376442301309 join aggView4782109357683745589 using(v1);
select SUM(annot) as v9 from aggJoin6482615917375369171;
