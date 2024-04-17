create or replace view aggView765674413780541717 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3645560180126225353 as select movie_id as v12 from movie_keyword as mk, aggView765674413780541717 where mk.keyword_id=aggView765674413780541717.v1;
create or replace view aggView4443939354044745267 as select v12 from aggJoin3645560180126225353 group by v12;
create or replace view aggJoin5660738555903054534 as select id as v12, title as v13, production_year as v16 from title as t, aggView4443939354044745267 where t.id=aggView4443939354044745267.v12 and production_year>2005;
create or replace view aggView4414932831143503087 as select v12, MIN(v13) as v24 from aggJoin5660738555903054534 group by v12;
create or replace view aggJoin758952086057759680 as select v24 from movie_info as mi, aggView4414932831143503087 where mi.movie_id=aggView4414932831143503087.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
select MIN(v24) as v24 from aggJoin758952086057759680;
