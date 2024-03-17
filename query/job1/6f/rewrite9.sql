create or replace view aggView4561808282195131940 as select id as v14, name as v36 from name as n;
create or replace view aggJoin8743967590974731774 as select movie_id as v23, v36 from cast_info as ci, aggView4561808282195131940 where ci.person_id=aggView4561808282195131940.v14;
create or replace view aggView1072719080022357271 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin3186185626644583655 as select v23, v36, v37 from aggJoin8743967590974731774 join aggView1072719080022357271 using(v23);
create or replace view aggView1766257290171997572 as select v23, MIN(v36) as v36, MIN(v37) as v37 from aggJoin3186185626644583655 group by v23;
create or replace view aggJoin1380994110567634489 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView1766257290171997572 where mk.movie_id=aggView1766257290171997572.v23;
create or replace view aggView7987812285497858924 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin1380994110567634489 group by v8;
create or replace view aggJoin7474193172944006521 as select keyword as v9, v36, v37 from keyword as k, aggView7987812285497858924 where k.id=aggView7987812285497858924.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7474193172944006521;
