create or replace view aggView2203887291521205575 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin1196601992590540892 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView2203887291521205575 where mk.movie_id=aggView2203887291521205575.v12;
create or replace view aggView1662723517339065951 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin4619263868555710518 as select v1, v24 as v24 from aggJoin1196601992590540892 join aggView1662723517339065951 using(v12);
create or replace view aggView458677204717394255 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2545996302393262395 as select v24 from aggJoin4619263868555710518 join aggView458677204717394255 using(v1);
select MIN(v24) as v24 from aggJoin2545996302393262395;
