create or replace view aggView3592216701317455680 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7871237594918518261 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3592216701317455680 where mc.company_type_id=aggView3592216701317455680.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView4916166738364926497 as select v15 from aggJoin7871237594918518261 group by v15;
create or replace view aggJoin4742472952267030326 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView4916166738364926497 where mi.movie_id=aggView4916166738364926497.v15 and info IN ('USA','America');
create or replace view aggView4332533441339835739 as select id as v3 from info_type as it;
create or replace view aggJoin679834181349084469 as select v15, v13 from aggJoin4742472952267030326 join aggView4332533441339835739 using(v3);
create or replace view aggView2585186487479638408 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin292654054694014764 as select v27 from aggJoin679834181349084469 join aggView2585186487479638408 using(v15);
select MIN(v27) as v27 from aggJoin292654054694014764;
