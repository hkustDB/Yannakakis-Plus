## AggReduce Phase: 

# AggReduce93
# 1. aggView
create or replace view aggView4565728828427783821 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin415710000157339417 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4565728828427783821 where Person_likes_Message.MessageId=aggView4565728828427783821.v1;

# AggReduce94
# 1. aggView
create or replace view aggView6249778998500733701 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin5648386048719601882 as select v1, aggJoin415710000157339417.annot * aggView6249778998500733701.annot as annot from aggJoin415710000157339417 join aggView6249778998500733701 using(v1);

# AggReduce95
# 1. aggView
create or replace view aggView4124160171005765085 as select v1, SUM(annot) as annot from aggJoin5648386048719601882 group by v1;
# 2. aggJoin
create or replace view aggJoin4621197294465366798 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4124160171005765085 where Comment_replyOf_Message.ParentMessageId=aggView4124160171005765085.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin4621197294465366798;

# drop view aggView4565728828427783821, aggJoin415710000157339417, aggView6249778998500733701, aggJoin5648386048719601882, aggView4124160171005765085, aggJoin4621197294465366798;
