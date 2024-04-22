create or replace view aggJoin1916104757968074907 as (
with aggView6194707463934606523 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView6194707463934606523 where ci.person_id=aggView6194707463934606523.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6326758098301785958 as (
with aggView2270308515793050900 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView2270308515793050900 where mi_idx.info_type_id=aggView2270308515793050900.v10);
create or replace view aggJoin5451721672191478407 as (
with aggView3702899384296003973 as (select v37, MIN(v23) as v50 from aggJoin6326758098301785958 group by v37)
select id as v37, title as v38, v50 from title as t, aggView3702899384296003973 where t.id=aggView3702899384296003973.v37);
create or replace view aggJoin2039763201627688213 as (
with aggView4460666836624317551 as (select v37, MIN(v50) as v50, MIN(v38) as v52 from aggJoin5451721672191478407 group by v37,v50)
select movie_id as v37, keyword_id as v12, v50, v52 from movie_keyword as mk, aggView4460666836624317551 where mk.movie_id=aggView4460666836624317551.v37);
create or replace view aggJoin1068163900428402186 as (
with aggView509123671734208812 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView509123671734208812 where mi.info_type_id=aggView509123671734208812.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin5696879041157128194 as (
with aggView2037356622157868575 as (select v37, MIN(v18) as v49 from aggJoin1068163900428402186 group by v37)
select v37, v5, v51 as v51, v49 from aggJoin1916104757968074907 join aggView2037356622157868575 using(v37));
create or replace view aggJoin7598897061886879942 as (
with aggView9012032145133452745 as (select v37, MIN(v51) as v51, MIN(v49) as v49 from aggJoin5696879041157128194 group by v37,v49,v51)
select v12, v50 as v50, v52 as v52, v51, v49 from aggJoin2039763201627688213 join aggView9012032145133452745 using(v37));
create or replace view aggJoin7901969728475868621 as (
with aggView1047981967280228624 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v50, v52, v51, v49 from aggJoin7598897061886879942 join aggView1047981967280228624 using(v12));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin7901969728475868621;
