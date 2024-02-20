## AggReduce Phase: 

# AggReduce60
# 1. aggView
create or replace view aggView6743955531431557411 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin874458582893234316 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6743955531431557411 where Message_hasTag_Tag.MessageId=aggView6743955531431557411.v1;

# AggReduce61
# 1. aggView
create or replace view aggView3364733519839111670 as select v1, SUM(annot) as annot from aggJoin874458582893234316 group by v1;
# 2. aggJoin
create or replace view aggJoin8852260582216714942 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3364733519839111670 where Person_likes_Message.MessageId=aggView3364733519839111670.v1;

# AggReduce62
# 1. aggView
create or replace view aggView809380560365948839 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin10376235049704013 as select aggJoin8852260582216714942.annot * aggView809380560365948839.annot as annot from aggJoin8852260582216714942 join aggView809380560365948839 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin10376235049704013;

# drop view aggView6743955531431557411, aggJoin874458582893234316, aggView3364733519839111670, aggJoin8852260582216714942, aggView809380560365948839, aggJoin10376235049704013;
