create or replace view aggView3328423826764061218 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7338584707952679168 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3328423826764061218 where mc.company_type_id=aggView3328423826764061218.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView5701954496163822080 as select id as v3 from info_type as it;
create or replace view aggJoin1605712176096476840 as select movie_id as v15, info as v13 from movie_info as mi, aggView5701954496163822080 where mi.info_type_id=aggView5701954496163822080.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView5058671260423720416 as select v15 from aggJoin7338584707952679168 group by v15;
create or replace view aggJoin5683720154030360718 as select v15, v13 from aggJoin1605712176096476840 join aggView5058671260423720416 using(v15);
create or replace view aggView4393586398244086536 as select v15 from aggJoin5683720154030360718 group by v15;
create or replace view aggJoin9013329042724225988 as select title as v16 from title as t, aggView4393586398244086536 where t.id=aggView4393586398244086536.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin9013329042724225988;
