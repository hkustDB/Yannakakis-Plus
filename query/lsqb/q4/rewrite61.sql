## AggReduce Phase: 

# AggReduce183
# 1. aggView
create or replace view aggView6151666697859677698 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin2324999931734504782 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6151666697859677698 where Message_hasCreator_Person.MessageId=aggView6151666697859677698.v1;

# AggReduce184
# 1. aggView
create or replace view aggView2084074570665577093 as select v1, SUM(annot) as annot from aggJoin2324999931734504782 group by v1;
# 2. aggJoin
create or replace view aggJoin8393521490239213497 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2084074570665577093 where Comment_replyOf_Message.ParentMessageId=aggView2084074570665577093.v1;

# AggReduce185
# 1. aggView
create or replace view aggView8691705338948466753 as select v1, SUM(annot) as annot from aggJoin8393521490239213497 group by v1;
# 2. aggJoin
create or replace view aggJoin862728780769718220 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8691705338948466753 where Message_hasTag_Tag.MessageId=aggView8691705338948466753.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin862728780769718220;

# drop view aggView6151666697859677698, aggJoin2324999931734504782, aggView2084074570665577093, aggJoin8393521490239213497, aggView8691705338948466753, aggJoin862728780769718220;
