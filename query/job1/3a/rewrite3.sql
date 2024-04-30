create or replace view aggView7855494104856914355 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin4377964010601930847 as select id as v12, title as v13, production_year as v16 from title as t, aggView7855494104856914355 where t.id=aggView7855494104856914355.v12 and production_year>2005;
create or replace view aggView8026241404991586413 as select v12, MIN(v13) as v24 from aggJoin4377964010601930847 group by v12;
create or replace view aggJoin625149666264706963 as select keyword_id as v1, v24 from movie_keyword as mk, aggView8026241404991586413 where mk.movie_id=aggView8026241404991586413.v12;
create or replace view aggView8141829936120526861 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5026355769204166129 as select v24 from aggJoin625149666264706963 join aggView8141829936120526861 using(v1);
select MIN(v24) as v24 from aggJoin5026355769204166129;
