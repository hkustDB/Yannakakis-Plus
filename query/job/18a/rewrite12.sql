create or replace view aggJoin3719600473697539511 as (
with aggView7606571741515077657 as (select id as v31, title as v45 from title as t)
select person_id as v22, movie_id as v31, note as v5, v45 from cast_info as ci, aggView7606571741515077657 where ci.movie_id=aggView7606571741515077657.v31 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin7190572778607920719 as (
with aggView2007363945775341659 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView2007363945775341659 where mi_idx.info_type_id=aggView2007363945775341659.v10);
create or replace view aggJoin7402468699390506208 as (
with aggView3194298201211760343 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select v31, v5, v45 from aggJoin3719600473697539511 join aggView3194298201211760343 using(v22));
create or replace view aggJoin7339893464048157492 as (
with aggView1636848510641207000 as (select v31, MIN(v45) as v45 from aggJoin7402468699390506208 group by v31,v45)
select v31, v20, v45 from aggJoin7190572778607920719 join aggView1636848510641207000 using(v31));
create or replace view aggJoin2195764198930173962 as (
with aggView8203683501257268327 as (select v31, MIN(v45) as v45, MIN(v20) as v44 from aggJoin7339893464048157492 group by v31,v45)
select info_type_id as v8, info as v15, v45, v44 from movie_info as mi, aggView8203683501257268327 where mi.movie_id=aggView8203683501257268327.v31);
create or replace view aggJoin3513914360439452639 as (
with aggView4217373597904587959 as (select id as v8 from info_type as it1 where info= 'budget')
select v15, v45, v44 from aggJoin2195764198930173962 join aggView4217373597904587959 using(v8));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3513914360439452639;
