create or replace view aggView962409938920769501 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin3814700270649103317 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView962409938920769501 where mc.movie_id=aggView962409938920769501.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView7051631874733852566 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4771739244793612000 as select v15, v9, v27 from aggJoin3814700270649103317 join aggView7051631874733852566 using(v1);
create or replace view aggView4656505299908814422 as select v15, MIN(v27) as v27 from aggJoin4771739244793612000 group by v15;
create or replace view aggJoin7336104529832762384 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView4656505299908814422 where mi.movie_id=aggView4656505299908814422.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView6979139689866737278 as select v3, MIN(v27) as v27 from aggJoin7336104529832762384 group by v3;
create or replace view aggJoin3582993273212043337 as select v27 from info_type as it, aggView6979139689866737278 where it.id=aggView6979139689866737278.v3;
select MIN(v27) as v27 from aggJoin3582993273212043337;
