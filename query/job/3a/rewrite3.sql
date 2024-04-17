create or replace view aggView6527756029768840236 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin4348680590549541354 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView6527756029768840236 where mk.movie_id=aggView6527756029768840236.v12;
create or replace view aggView6326727323643573656 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7071027569251464324 as select v12 from aggJoin4348680590549541354 join aggView6326727323643573656 using(v1);
create or replace view aggView8364693837297837720 as select v12 from aggJoin7071027569251464324 group by v12;
create or replace view aggJoin4316693245593300346 as select title as v13, production_year as v16 from title as t, aggView8364693837297837720 where t.id=aggView8364693837297837720.v12 and production_year>2005;
create or replace view aggView5636160080945208256 as select v13 from aggJoin4316693245593300346 group by v13;
select MIN(v13) as v24 from aggView5636160080945208256;
