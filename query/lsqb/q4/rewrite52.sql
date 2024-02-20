## AggReduce Phase: 

# AggReduce156
# 1. aggView
create or replace view aggView6803408110374104393 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin770947295680222054 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6803408110374104393 where Comment_replyOf_Message.ParentMessageId=aggView6803408110374104393.v1;

# AggReduce157
# 1. aggView
create or replace view aggView7330943946123467449 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin14603293822379482 as select v1, aggJoin770947295680222054.annot * aggView7330943946123467449.annot as annot from aggJoin770947295680222054 join aggView7330943946123467449 using(v1);

# AggReduce158
# 1. aggView
create or replace view aggView4163434841948681145 as select v1, SUM(annot) as annot from aggJoin14603293822379482 group by v1;
# 2. aggJoin
create or replace view aggJoin5923195594081544908 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView4163434841948681145 where Message_hasCreator_Person.MessageId=aggView4163434841948681145.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin5923195594081544908;

# drop view aggView6803408110374104393, aggJoin770947295680222054, aggView7330943946123467449, aggJoin14603293822379482, aggView4163434841948681145, aggJoin5923195594081544908;
