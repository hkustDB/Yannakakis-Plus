## AggReduce Phase: 

# AggReduce72
# 1. aggView
create or replace view aggView3234163070663786608 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin8654525389994489617 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3234163070663786608 where Message_hasCreator_Person.MessageId=aggView3234163070663786608.v1;

# AggReduce73
# 1. aggView
create or replace view aggView8958602949289859077 as select v1, SUM(annot) as annot from aggJoin8654525389994489617 group by v1;
# 2. aggJoin
create or replace view aggJoin6662026981683428754 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8958602949289859077 where Message_hasTag_Tag.MessageId=aggView8958602949289859077.v1;

# AggReduce74
# 1. aggView
create or replace view aggView704848309608420333 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin745469301742374724 as select aggJoin6662026981683428754.annot * aggView704848309608420333.annot as annot from aggJoin6662026981683428754 join aggView704848309608420333 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin745469301742374724;

# drop view aggView3234163070663786608, aggJoin8654525389994489617, aggView8958602949289859077, aggJoin6662026981683428754, aggView704848309608420333, aggJoin745469301742374724;
