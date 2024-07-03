create or replace view aggView1553881279828019599 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin3709923660601392433 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView1553881279828019599 where mc.movie_id=aggView1553881279828019599.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView258791780586996078 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8695446117898518911 as select v15, v9, v27 from aggJoin3709923660601392433 join aggView258791780586996078 using(v1);
create or replace view aggView7956267242832122279 as select id as v3 from info_type as it;
create or replace view aggJoin6542159990310874805 as select movie_id as v15, info as v13 from movie_info as mi, aggView7956267242832122279 where mi.info_type_id=aggView7956267242832122279.v3 and info IN ('USA','America');
create or replace view aggView7961009422405592686 as select v15, MIN(v27) as v27 from aggJoin8695446117898518911 group by v15,v27;
create or replace view aggJoin1306594966203817063 as select v27 from aggJoin6542159990310874805 join aggView7961009422405592686 using(v15);
select MIN(v27) as v27 from aggJoin1306594966203817063;
