create or replace view aggJoin1025536138946510788 as (
with aggView6566199676271886112 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView6566199676271886112 where mi_idx.info_type_id=aggView6566199676271886112.v1);
create or replace view aggJoin8360442751645794835 as (
with aggView6431596676803990542 as (select v9, v14 from aggJoin1025536138946510788 group by v9,v14)
select v14, v9 from aggView6431596676803990542 where v9>'5.0');
create or replace view aggJoin6569262007402399999 as (
with aggView6569908330652124968 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView6569908330652124968 where mk.keyword_id=aggView6569908330652124968.v3);
create or replace view aggJoin4589927697120611382 as (
with aggView8082273100096125019 as (select v14 from aggJoin6569262007402399999 group by v14)
select id as v14, title as v15, production_year as v18 from title as t, aggView8082273100096125019 where t.id=aggView8082273100096125019.v14 and production_year>2005);
create or replace view aggView5891687466777439278 as select v14, v15 from aggJoin4589927697120611382 group by v14,v15;
create or replace view aggJoin8808605179700890916 as (
with aggView4065648423637616535 as (select v14, MIN(v9) as v26 from aggJoin8360442751645794835 group by v14)
select v15, v26 from aggView5891687466777439278 join aggView4065648423637616535 using(v14));
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin8808605179700890916;
