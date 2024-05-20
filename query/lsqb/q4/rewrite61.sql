create or replace view aggView8350852310661706142 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin3810925356892926747 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8350852310661706142 where Message_hasCreator_Person.MessageId=aggView8350852310661706142.v1;
create or replace view aggView4612403555276366775 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin854368199255659192 as select v1, aggJoin3810925356892926747.annot * aggView4612403555276366775.annot as annot from aggJoin3810925356892926747 join aggView4612403555276366775 using(v1);
create or replace view aggView7815936055922035487 as select v1, SUM(annot) as annot from aggJoin854368199255659192 group by v1;
create or replace view aggJoin1131287448514521089 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7815936055922035487 where Comment_replyOf_Message.ParentMessageId=aggView7815936055922035487.v1;
select SUM(annot) as v9 from aggJoin1131287448514521089;
