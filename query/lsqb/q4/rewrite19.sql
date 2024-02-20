## AggReduce Phase: 

# AggReduce57
# 1. aggView
create or replace view aggView8593716869860001822 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin8181733121133226148 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView8593716869860001822 where Person_likes_Message.MessageId=aggView8593716869860001822.v1;

# AggReduce58
# 1. aggView
create or replace view aggView3227053073998887007 as select v1, SUM(annot) as annot from aggJoin8181733121133226148 group by v1;
# 2. aggJoin
create or replace view aggJoin1602361557980845645 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3227053073998887007 where Message_hasCreator_Person.MessageId=aggView3227053073998887007.v1;

# AggReduce59
# 1. aggView
create or replace view aggView4608392088150810624 as select v1, SUM(annot) as annot from aggJoin1602361557980845645 group by v1;
# 2. aggJoin
create or replace view aggJoin3917835183168031018 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4608392088150810624 where Message_hasTag_Tag.MessageId=aggView4608392088150810624.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin3917835183168031018;

# drop view aggView8593716869860001822, aggJoin8181733121133226148, aggView3227053073998887007, aggJoin1602361557980845645, aggView4608392088150810624, aggJoin3917835183168031018;
