create or replace view aggView4980943088354231901 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin8551764453503766922 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView4980943088354231901 where ci.movie_id=aggView4980943088354231901.v23;
create or replace view aggView8681839349802606867 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4407800681678200960 as select movie_id as v23, v35 from movie_keyword as mk, aggView8681839349802606867 where mk.keyword_id=aggView8681839349802606867.v8;
create or replace view aggView5142696005768927378 as select v23, MIN(v35) as v35 from aggJoin4407800681678200960 group by v23;
create or replace view aggJoin3778843858258393489 as select v14, v37 as v37, v35 from aggJoin8551764453503766922 join aggView5142696005768927378 using(v23);
create or replace view aggView7423976697010891855 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin3778843858258393489 group by v14;
create or replace view aggJoin3952377631618555926 as select name as v15, v37, v35 from name as n, aggView7423976697010891855 where n.id=aggView7423976697010891855.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin3952377631618555926;
