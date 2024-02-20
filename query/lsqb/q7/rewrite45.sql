## AggReduce Phase: 

# AggReduce135
# 1. aggView
create or replace view aggView8478850199326768353 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin2476278674655925174 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8478850199326768353 where Message_hasTag_Tag.MessageId=aggView8478850199326768353.v1;

# AggReduce136
# 1. aggView
create or replace view aggView1177139021470102606 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin4904882396748011637 as select v1, aggJoin2476278674655925174.annot * aggView1177139021470102606.annot as annot from aggJoin2476278674655925174 join aggView1177139021470102606 using(v1);

# AggReduce137
# 1. aggView
create or replace view aggView6027849662088837808 as select v1, SUM(annot) as annot from aggJoin4904882396748011637 group by v1;
# 2. aggJoin
create or replace view aggJoin8897277977300105924 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6027849662088837808 where Message_hasCreator_Person.MessageId=aggView6027849662088837808.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin8897277977300105924;

# drop view aggView8478850199326768353, aggJoin2476278674655925174, aggView1177139021470102606, aggJoin4904882396748011637, aggView6027849662088837808, aggJoin8897277977300105924;
