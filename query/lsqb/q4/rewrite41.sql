## AggReduce Phase: 

# AggReduce123
# 1. aggView
create or replace view aggView3866727922115850068 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin5643794280230766012 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3866727922115850068 where Person_likes_Message.MessageId=aggView3866727922115850068.v1;

# AggReduce124
# 1. aggView
create or replace view aggView2740535813437309436 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin989718089425003902 as select v1, aggJoin5643794280230766012.annot * aggView2740535813437309436.annot as annot from aggJoin5643794280230766012 join aggView2740535813437309436 using(v1);

# AggReduce125
# 1. aggView
create or replace view aggView8875616625400227194 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin231041363918196068 as select aggJoin989718089425003902.annot * aggView8875616625400227194.annot as annot from aggJoin989718089425003902 join aggView8875616625400227194 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin231041363918196068;

# drop view aggView3866727922115850068, aggJoin5643794280230766012, aggView2740535813437309436, aggJoin989718089425003902, aggView8875616625400227194, aggJoin231041363918196068;
