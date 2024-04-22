create or replace view aggJoin7467739616853862148 as (
with aggView2084341726905838133 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView2084341726905838133 where mc.company_type_id=aggView2084341726905838133.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggView433402644116112137 as select v15, v9 from aggJoin7467739616853862148 group by v15,v9;
create or replace view aggJoin5009216220404628829 as (
with aggView4595313464601870293 as (select id as v3 from info_type as it where info= 'bottom 10 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView4595313464601870293 where mi_idx.info_type_id=aggView4595313464601870293.v3);
create or replace view aggJoin5044752576808867382 as (
with aggView8753695566283920058 as (select v15 from aggJoin5009216220404628829 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView8753695566283920058 where t.id=aggView8753695566283920058.v15 and production_year<=2010 and production_year>=2005);
create or replace view aggView3461758376348187027 as select v15, v16, v19 from aggJoin5044752576808867382 group by v15,v16,v19;
create or replace view aggJoin9053052994266956794 as (
with aggView851216490658311502 as (select v15, MIN(v16) as v28, MIN(v19) as v29 from aggView3461758376348187027 group by v15)
select v9, v28, v29 from aggView433402644116112137 join aggView851216490658311502 using(v15));
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin9053052994266956794;
