create or replace view aggView8805959398495728879 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggView8491318969898980 as select id as v29, title as v30 from title as t where production_year>=2000 and production_year<=2010;
create or replace view aggJoin7647681814395274482 as (
with aggView3898922999453052538 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView3898922999453052538 where mi_idx.info_type_id=aggView3898922999453052538.v26);
create or replace view aggJoin7970735845980078957 as (
with aggView8138979911804323336 as (select v29, v27 from aggJoin7647681814395274482 group by v29,v27)
select v29, v27 from aggView8138979911804323336 where v27>'7.0');
create or replace view aggJoin3307760567564276304 as (
with aggView3145104775964904548 as (select v29, MIN(v27) as v42 from aggJoin7970735845980078957 group by v29)
select v29, v30, v42 from aggView8491318969898980 join aggView3145104775964904548 using(v29));
create or replace view aggJoin1668204165832533928 as (
with aggView7336752481960027769 as (select v29, MIN(v42) as v42, MIN(v30) as v43 from aggJoin3307760567564276304 group by v29,v42)
select movie_id as v29, company_id as v1, company_type_id as v8, v42, v43 from movie_companies as mc, aggView7336752481960027769 where mc.movie_id=aggView7336752481960027769.v29);
create or replace view aggJoin2318020135797359292 as (
with aggView2135576878436279798 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v1, v42, v43 from aggJoin1668204165832533928 join aggView2135576878436279798 using(v8));
create or replace view aggJoin5905080692594245756 as (
with aggView7329012519332401542 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView7329012519332401542 where mi.info_type_id=aggView7329012519332401542.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin6041174052872528202 as (
with aggView2134338911158073713 as (select v29 from aggJoin5905080692594245756 group by v29)
select v1, v42 as v42, v43 as v43 from aggJoin2318020135797359292 join aggView2134338911158073713 using(v29));
create or replace view aggJoin1189319915495399929 as (
with aggView6912530967789137546 as (select v1, MIN(v42) as v42, MIN(v43) as v43 from aggJoin6041174052872528202 group by v1,v42,v43)
select v2, v42, v43 from aggView8805959398495728879 join aggView6912530967789137546 using(v1));
select MIN(v2) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin1189319915495399929;
