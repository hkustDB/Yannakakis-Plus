create or replace view aggView6286416905944076299 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin2486429865424569426 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6286416905944076299 where Comment_replyOf_Message.ParentMessageId=aggView6286416905944076299.v1;
create or replace view aggView8927365844340589474 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin2451201603375183197 as select v1, aggJoin2486429865424569426.annot * aggView8927365844340589474.annot as annot from aggJoin2486429865424569426 join aggView8927365844340589474 using(v1);
create or replace view aggView4806657628634595244 as select v1, SUM(annot) as annot from aggJoin2451201603375183197 group by v1;
create or replace view aggJoin7894967227129835341 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4806657628634595244 where Message_hasTag_Tag.MessageId=aggView4806657628634595244.v1;
select SUM(annot) as v9 from aggJoin7894967227129835341;
