create or replace view aggView5876163835096232609 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin8652418983887529783 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5876163835096232609 where Comment_replyOf_Message.ParentMessageId=aggView5876163835096232609.v1;
create or replace view aggView33690918132247514 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin8482607956365261332 as select v1, aggJoin8652418983887529783.annot * aggView33690918132247514.annot as annot from aggJoin8652418983887529783 join aggView33690918132247514 using(v1);
create or replace view aggView5164652259959350266 as select v1, SUM(annot) as annot from aggJoin8482607956365261332 group by v1;
create or replace view aggJoin8159685864049308063 as select annot from Person_likes_Message as Person_likes_Message, aggView5164652259959350266 where Person_likes_Message.MessageId=aggView5164652259959350266.v1;
select SUM(annot) as v9 from aggJoin8159685864049308063;
