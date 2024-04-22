create or replace view aggView9007417316370055044 as select title as v32, id as v31 from title as t;
create or replace view aggJoin1777930830855440600 as (
with aggView7391969235225485609 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView7391969235225485609 where ci.person_id=aggView7391969235225485609.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin116281722758680408 as (
with aggView6236671003762447160 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView6236671003762447160 where mi_idx.info_type_id=aggView6236671003762447160.v10);
create or replace view aggView6686899840323020566 as select v31, v20 from aggJoin116281722758680408 group by v31,v20;
create or replace view aggJoin3390187494202389460 as (
with aggView3116988309031718336 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView3116988309031718336 where mi.info_type_id=aggView3116988309031718336.v8);
create or replace view aggJoin5865134393564971927 as (
with aggView2170263714599362182 as (select v31 from aggJoin1777930830855440600 group by v31)
select v31, v15 from aggJoin3390187494202389460 join aggView2170263714599362182 using(v31));
create or replace view aggJoin5374661105240956710 as (
with aggView1942833946563927056 as (select v31, v15 from aggJoin5865134393564971927 group by v31,v15)
select v31, v15 from aggView1942833946563927056 where v15 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2229362861649338335 as (
with aggView3857916750246197897 as (select v31, MIN(v20) as v44 from aggView6686899840323020566 group by v31)
select v32, v31, v44 from aggView9007417316370055044 join aggView3857916750246197897 using(v31));
create or replace view aggJoin5670856728035372277 as (
with aggView8052003383520281793 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin2229362861649338335 group by v31,v44)
select v15, v44, v45 from aggJoin5374661105240956710 join aggView8052003383520281793 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin5670856728035372277;
