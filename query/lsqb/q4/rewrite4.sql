## AggReduce Phase: 

# AggReduce12
# 1. aggView
create or replace view aggView1752232188644312765 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin7346094294034120027 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1752232188644312765 where Message_hasTag_Tag.MessageId=aggView1752232188644312765.v1;

# AggReduce13
# 1. aggView
create or replace view aggView4456435533342225226 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin9070867174394667163 as select v1, aggJoin7346094294034120027.annot * aggView4456435533342225226.annot as annot from aggJoin7346094294034120027 join aggView4456435533342225226 using(v1);

# AggReduce14
# 1. aggView
create or replace view aggView7491693457060211947 as select v1, SUM(annot) as annot from aggJoin9070867174394667163 group by v1;
# 2. aggJoin
create or replace view aggJoin315790032184987849 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7491693457060211947 where Message_hasCreator_Person.MessageId=aggView7491693457060211947.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin315790032184987849;

# drop view aggView1752232188644312765, aggJoin7346094294034120027, aggView4456435533342225226, aggJoin9070867174394667163, aggView7491693457060211947, aggJoin315790032184987849;
