create or replace view aggView3763829771533894146 as select id as v23 from title as t where production_year>2000;
create or replace view aggJoin8251206716871840685 as select movie_id as v23, keyword_id as v8 from movie_keyword as mk, aggView3763829771533894146 where mk.movie_id=aggView3763829771533894146.v23;
create or replace view aggView321186857540030190 as select id as v8 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5776787864232048433 as select v23 from aggJoin8251206716871840685 join aggView321186857540030190 using(v8);
create or replace view aggView3568366399916153528 as select v23, COUNT(*) as annot from aggJoin5776787864232048433 group by v23;
create or replace view aggJoin6030910266970823559 as select person_id as v14, annot from cast_info as ci, aggView3568366399916153528 where ci.movie_id=aggView3568366399916153528.v23;
create or replace view aggView7997698656996959250 as select v14, SUM(annot) as annot from aggJoin6030910266970823559 group by v14;
create or replace view aggJoin5842564201484485203 as select annot from name as n, aggView7997698656996959250 where n.id=aggView7997698656996959250.v14;
select SUM(annot) as v35 from aggJoin5842564201484485203;
