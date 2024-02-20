## AggReduce Phase: 

# AggReduce111
# 1. aggView
create or replace view aggView1315374651743820252 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin1585281662685626340 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView1315374651743820252 where Person_likes_Message.MessageId=aggView1315374651743820252.v1;

# AggReduce112
# 1. aggView
create or replace view aggView7457519154067644846 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin1559891258980646961 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7457519154067644846 where Message_hasTag_Tag.MessageId=aggView7457519154067644846.v1;

# AggReduce113
# 1. aggView
create or replace view aggView8855588204343212056 as select v1, SUM(annot) as annot from aggJoin1559891258980646961 group by v1;
# 2. aggJoin
create or replace view aggJoin3814819897594795930 as select aggJoin1585281662685626340.annot * aggView8855588204343212056.annot as annot from aggJoin1585281662685626340 join aggView8855588204343212056 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin3814819897594795930;

# drop view aggView1315374651743820252, aggJoin1585281662685626340, aggView7457519154067644846, aggJoin1559891258980646961, aggView8855588204343212056, aggJoin3814819897594795930;
