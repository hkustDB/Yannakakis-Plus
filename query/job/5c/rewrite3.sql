create or replace view aggView6992949202852181334 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1862761619553958291 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6992949202852181334 where mc.company_type_id=aggView6992949202852181334.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView8791542904125671749 as select v15 from aggJoin1862761619553958291 group by v15;
create or replace view aggJoin794644473367347124 as select id as v15, title as v16, production_year as v19 from title as t, aggView8791542904125671749 where t.id=aggView8791542904125671749.v15 and production_year>1990;
create or replace view aggView526386339513560937 as select v15, MIN(v16) as v27 from aggJoin794644473367347124 group by v15;
create or replace view aggJoin7477686956868480709 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView526386339513560937 where mi.movie_id=aggView526386339513560937.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView2459839422629728109 as select id as v3 from info_type as it;
create or replace view aggJoin153628666674771231 as select v27 from aggJoin7477686956868480709 join aggView2459839422629728109 using(v3);
select MIN(v27) as v27 from aggJoin153628666674771231;
