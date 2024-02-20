## AggReduce Phase: 

# AggReduce114
# 1. aggView
create or replace view aggView6225158138456050398 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin8872254458926304522 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6225158138456050398 where Comment_replyOf_Message.ParentMessageId=aggView6225158138456050398.v1;

# AggReduce115
# 1. aggView
create or replace view aggView2085673139355430762 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin6787081558511524279 as select v1, aggJoin8872254458926304522.annot * aggView2085673139355430762.annot as annot from aggJoin8872254458926304522 join aggView2085673139355430762 using(v1);

# AggReduce116
# 1. aggView
create or replace view aggView650245204298955426 as select v1, SUM(annot) as annot from aggJoin6787081558511524279 group by v1;
# 2. aggJoin
create or replace view aggJoin4892608193727694330 as select annot from Person_likes_Message as Person_likes_Message, aggView650245204298955426 where Person_likes_Message.MessageId=aggView650245204298955426.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin4892608193727694330;

# drop view aggView6225158138456050398, aggJoin8872254458926304522, aggView2085673139355430762, aggJoin6787081558511524279, aggView650245204298955426, aggJoin4892608193727694330;
