create or replace view aggView6447067811867894887 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin414875395856954032 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6447067811867894887 where Comment_replyOf_Message.ParentMessageId=aggView6447067811867894887.v1;
create or replace view aggView7325020102092222865 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin1372762204097638768 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7325020102092222865 where Message_hasTag_Tag.MessageId=aggView7325020102092222865.v1;
create or replace view aggView2895510353040047132 as select v1, SUM(annot) as annot from aggJoin1372762204097638768 group by v1;
create or replace view aggJoin4991968304793125087 as select aggJoin414875395856954032.annot * aggView2895510353040047132.annot as annot from aggJoin414875395856954032 join aggView2895510353040047132 using(v1);
select SUM(annot) as v9 from aggJoin4991968304793125087;
