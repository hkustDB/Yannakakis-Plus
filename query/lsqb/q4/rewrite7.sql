create or replace view aggView4844367522573388004 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin2158735296281622158 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4844367522573388004 where Person_likes_Message.MessageId=aggView4844367522573388004.v1;
create or replace view aggView6773714475010151212 as select v1, SUM(annot) as annot from aggJoin2158735296281622158 group by v1;
create or replace view aggJoin6796778561806414365 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6773714475010151212 where Message_hasTag_Tag.MessageId=aggView6773714475010151212.v1;
create or replace view aggView7151792393333510184 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin3079214319862718800 as select aggJoin6796778561806414365.annot * aggView7151792393333510184.annot as annot from aggJoin6796778561806414365 join aggView7151792393333510184 using(v1);
select SUM(annot) as v9 from aggJoin3079214319862718800;
