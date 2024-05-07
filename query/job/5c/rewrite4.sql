create or replace view aggView3054318706202843508 as select id as v3 from info_type as it;
create or replace view aggJoin1291019979116785237 as select movie_id as v15, info as v13 from movie_info as mi, aggView3054318706202843508 where mi.info_type_id=aggView3054318706202843508.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3153385893675333904 as select v15 from aggJoin1291019979116785237 group by v15;
create or replace view aggJoin5351045588196816672 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView3153385893675333904 where mc.movie_id=aggView3153385893675333904.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView2026329933650032488 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin860257046297226565 as select v15, v9 from aggJoin5351045588196816672 join aggView2026329933650032488 using(v1);
create or replace view aggView6549540912028915641 as select v15 from aggJoin860257046297226565 group by v15;
create or replace view aggJoin3734943578935523706 as select title as v16 from title as t, aggView6549540912028915641 where t.id=aggView6549540912028915641.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin3734943578935523706;
