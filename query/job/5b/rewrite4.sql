create or replace view aggView2123855778808992472 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1018972515783458293 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2123855778808992472 where mc.company_type_id=aggView2123855778808992472.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView3111795973439575275 as select v15 from aggJoin1018972515783458293 group by v15;
create or replace view aggJoin4621370839909255112 as select id as v15, title as v16, production_year as v19 from title as t, aggView3111795973439575275 where t.id=aggView3111795973439575275.v15 and production_year>2010;
create or replace view aggView1357644135369126104 as select v15, MIN(v16) as v27 from aggJoin4621370839909255112 group by v15;
create or replace view aggJoin4427586765025729389 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView1357644135369126104 where mi.movie_id=aggView1357644135369126104.v15 and info IN ('USA','America');
create or replace view aggView2006963139978347337 as select id as v3 from info_type as it;
create or replace view aggJoin1958366930693598173 as select v27 from aggJoin4427586765025729389 join aggView2006963139978347337 using(v3);
select MIN(v27) as v27 from aggJoin1958366930693598173;
