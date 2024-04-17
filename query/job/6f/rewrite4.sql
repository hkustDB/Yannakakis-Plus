create or replace view aggView5801856216104882846 as select id as v14, name as v36 from name as n;
create or replace view aggJoin303025213480235069 as select movie_id as v23, v36 from cast_info as ci, aggView5801856216104882846 where ci.person_id=aggView5801856216104882846.v14;
create or replace view aggView1163702621600665129 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin8584562136950814435 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView1163702621600665129 where mk.movie_id=aggView1163702621600665129.v23;
create or replace view aggView4858056633789931439 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3156939789109345224 as select v23, v37, v35 from aggJoin8584562136950814435 join aggView4858056633789931439 using(v8);
create or replace view aggView6062297927712376211 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin3156939789109345224 group by v23,v37,v35;
create or replace view aggJoin4772188621664939717 as select v36 as v36, v37, v35 from aggJoin303025213480235069 join aggView6062297927712376211 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4772188621664939717;
