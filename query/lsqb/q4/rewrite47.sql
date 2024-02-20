## AggReduce Phase: 

# AggReduce141
# 1. aggView
create or replace view aggView3056238227231971348 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin2152060554220295205 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3056238227231971348 where Message_hasCreator_Person.MessageId=aggView3056238227231971348.v1;

# AggReduce142
# 1. aggView
create or replace view aggView6808756331807387 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin3068338433224755482 as select v1, aggJoin2152060554220295205.annot * aggView6808756331807387.annot as annot from aggJoin2152060554220295205 join aggView6808756331807387 using(v1);

# AggReduce143
# 1. aggView
create or replace view aggView315095050078911406 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin1796720737694870151 as select aggJoin3068338433224755482.annot * aggView315095050078911406.annot as annot from aggJoin3068338433224755482 join aggView315095050078911406 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin1796720737694870151;

# drop view aggView3056238227231971348, aggJoin2152060554220295205, aggView6808756331807387, aggJoin3068338433224755482, aggView315095050078911406, aggJoin1796720737694870151;
