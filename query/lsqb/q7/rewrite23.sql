create or replace view aggView8901869944177234981 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin8298013336435306546 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8901869944177234981 where Message_hasCreator_Person.MessageId=aggView8901869944177234981.v1;
create or replace view aggView8115448268481298579 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin6963289569529789078 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8115448268481298579 where Comment_replyOf_Message.ParentMessageId=aggView8115448268481298579.v1;
create or replace view aggView5698847819543069824 as select v1, SUM(annot) as annot from aggJoin6963289569529789078 group by v1;
create or replace view aggJoin2991728445200416189 as select aggJoin8298013336435306546.annot * aggView5698847819543069824.annot as annot from aggJoin8298013336435306546 join aggView5698847819543069824 using(v1);
select SUM(annot) as v9 from aggJoin2991728445200416189;
