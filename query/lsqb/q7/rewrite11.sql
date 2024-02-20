## AggReduce Phase: 

# AggReduce33
# 1. aggView
create or replace view aggView5842187819666959674 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin3670901984332518297 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5842187819666959674 where Comment_replyOf_Message.ParentMessageId=aggView5842187819666959674.v1;

# AggReduce34
# 1. aggView
create or replace view aggView8938449433573314530 as select v1, SUM(annot) as annot from aggJoin3670901984332518297 group by v1;
# 2. aggJoin
create or replace view aggJoin2837014680818760963 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView8938449433573314530 where Person_likes_Message.MessageId=aggView8938449433573314530.v1;

# AggReduce35
# 1. aggView
create or replace view aggView6285784164639562812 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin1383403418370715131 as select aggJoin2837014680818760963.annot * aggView6285784164639562812.annot as annot from aggJoin2837014680818760963 join aggView6285784164639562812 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin1383403418370715131;

# drop view aggView5842187819666959674, aggJoin3670901984332518297, aggView8938449433573314530, aggJoin2837014680818760963, aggView6285784164639562812, aggJoin1383403418370715131;
