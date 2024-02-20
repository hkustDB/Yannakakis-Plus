## AggReduce Phase: 

# AggReduce45
# 1. aggView
create or replace view aggView8120831002369739600 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin1770059298885888922 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8120831002369739600 where Comment_replyOf_Message.ParentMessageId=aggView8120831002369739600.v1;

# AggReduce46
# 1. aggView
create or replace view aggView2596757650046994604 as select v1, SUM(annot) as annot from aggJoin1770059298885888922 group by v1;
# 2. aggJoin
create or replace view aggJoin8744148165064849276 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView2596757650046994604 where Person_likes_Message.MessageId=aggView2596757650046994604.v1;

# AggReduce47
# 1. aggView
create or replace view aggView8634529731228370489 as select v1, SUM(annot) as annot from aggJoin8744148165064849276 group by v1;
# 2. aggJoin
create or replace view aggJoin582660004911928251 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8634529731228370489 where Message_hasCreator_Person.MessageId=aggView8634529731228370489.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin582660004911928251;

# drop view aggView8120831002369739600, aggJoin1770059298885888922, aggView2596757650046994604, aggJoin8744148165064849276, aggView8634529731228370489, aggJoin582660004911928251;
