create or replace view aggJoin6549486444142020570 as (
with aggView7444466317508643535 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView7444466317508643535 where mi_idx.info_type_id=aggView7444466317508643535.v3);
create or replace view aggJoin5971327943116062479 as (
with aggView3846608255374551430 as (select v15 from aggJoin6549486444142020570 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView3846608255374551430 where t.id=aggView3846608255374551430.v15);
create or replace view aggView3111399373422278607 as select v16, v19, v15 from aggJoin5971327943116062479 group by v16,v19,v15;
create or replace view aggJoin1064851223081591760 as (
with aggView8838372320974045324 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView8838372320974045324 where mc.company_type_id=aggView8838372320974045324.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggView406298289874848599 as select v15, v9 from aggJoin1064851223081591760 group by v15,v9;
create or replace view aggJoin7242777900918203649 as (
with aggView4048652507291141567 as (select v15, MIN(v16) as v28, MIN(v19) as v29 from aggView3111399373422278607 group by v15)
select v9, v28, v29 from aggView406298289874848599 join aggView4048652507291141567 using(v15));
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7242777900918203649;
