## AggReduce Phase: 

# AggReduce168
# 1. aggView
create or replace view aggView7997455931979288282 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin674302850148714810 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7997455931979288282 where Comment_replyOf_Message.ParentMessageId=aggView7997455931979288282.v1;

# AggReduce169
# 1. aggView
create or replace view aggView2658960810203740182 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin4707078468849051024 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2658960810203740182 where Message_hasCreator_Person.MessageId=aggView2658960810203740182.v1;

# AggReduce170
# 1. aggView
create or replace view aggView6674141226631050527 as select v1, SUM(annot) as annot from aggJoin4707078468849051024 group by v1;
# 2. aggJoin
create or replace view aggJoin8867493901079023876 as select aggJoin674302850148714810.annot * aggView6674141226631050527.annot as annot from aggJoin674302850148714810 join aggView6674141226631050527 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin8867493901079023876;

# drop view aggView7997455931979288282, aggJoin674302850148714810, aggView2658960810203740182, aggJoin4707078468849051024, aggView6674141226631050527, aggJoin8867493901079023876;
