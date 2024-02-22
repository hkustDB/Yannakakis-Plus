create or replace view aggView8349392128267194257 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin4508498545181401564 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8349392128267194257 where Message_hasCreator_Person.MessageId=aggView8349392128267194257.v1;
create or replace view aggView5408368975987132662 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin2461481058942284898 as select v1, aggJoin4508498545181401564.annot * aggView5408368975987132662.annot as annot from aggJoin4508498545181401564 join aggView5408368975987132662 using(v1);
create or replace view aggView5655090955257494981 as select v1, SUM(annot) as annot from aggJoin2461481058942284898 group by v1;
create or replace view aggJoin590051672848448116 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5655090955257494981 where Message_hasTag_Tag.MessageId=aggView5655090955257494981.v1;
select SUM(annot) as v9 from aggJoin590051672848448116;
