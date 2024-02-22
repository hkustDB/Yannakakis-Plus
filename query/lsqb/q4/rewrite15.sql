create or replace view aggView1567136839399176719 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin6560961553552368754 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1567136839399176719 where Message_hasCreator_Person.MessageId=aggView1567136839399176719.v1;
create or replace view aggView2542021142347258189 as select v1, SUM(annot) as annot from aggJoin6560961553552368754 group by v1;
create or replace view aggJoin4725007653713998235 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2542021142347258189 where Comment_replyOf_Message.ParentMessageId=aggView2542021142347258189.v1;
create or replace view aggView8453786441234251321 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7490765575385637381 as select aggJoin4725007653713998235.annot * aggView8453786441234251321.annot as annot from aggJoin4725007653713998235 join aggView8453786441234251321 using(v1);
select SUM(annot) as v9 from aggJoin7490765575385637381;
