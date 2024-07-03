create or replace view aggView2781418727512623870 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3104704129848886333 as select movie_id as v12 from movie_keyword as mk, aggView2781418727512623870 where mk.keyword_id=aggView2781418727512623870.v1;
create or replace view aggView8395532936714301702 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin4896270862143716572 as select v12 from aggJoin3104704129848886333 join aggView8395532936714301702 using(v12);
create or replace view aggView1148281052518206758 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin4088971924349190529 as select v24 from aggJoin4896270862143716572 join aggView1148281052518206758 using(v12);
select MIN(v24) as v24 from aggJoin4088971924349190529;
