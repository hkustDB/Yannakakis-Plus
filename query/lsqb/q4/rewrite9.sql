## AggReduce Phase: 

# AggReduce27
# 1. aggView
create or replace view aggView6903094031735232194 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin370272386727936893 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6903094031735232194 where Message_hasTag_Tag.MessageId=aggView6903094031735232194.v1;

# AggReduce28
# 1. aggView
create or replace view aggView2011012465677370875 as select v1, SUM(annot) as annot from aggJoin370272386727936893 group by v1;
# 2. aggJoin
create or replace view aggJoin3864820999667177304 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2011012465677370875 where Message_hasCreator_Person.MessageId=aggView2011012465677370875.v1;

# AggReduce29
# 1. aggView
create or replace view aggView1959343403016003886 as select v1, SUM(annot) as annot from aggJoin3864820999667177304 group by v1;
# 2. aggJoin
create or replace view aggJoin1707651238567311349 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1959343403016003886 where Comment_replyOf_Message.ParentMessageId=aggView1959343403016003886.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin1707651238567311349;

# drop view aggView6903094031735232194, aggJoin370272386727936893, aggView2011012465677370875, aggJoin3864820999667177304, aggView1959343403016003886, aggJoin1707651238567311349;
